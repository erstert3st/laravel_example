local.file_match "fail2ban" {
	path_targets = [{
		__address__ = "localhost",
		__path__    = "/var/log/fail2ban/fail2ban.log",
		app         = "fail2ban",
		env         = "test-env",
		instance    = "your-instance-identifier",
	}]
}

loki.process "fail2ban" {
	forward_to = [loki.write.default.receiver]

	stage.multiline {
		firstline     = "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
		max_lines     = 0
		max_wait_time = "0s"
	}

	stage.regex {
		expression = "^(?s)(?P<time>\\S+? \\S+?) (fail2ban\\.)(?P<component>\\S+)\\s* \\[(?P<pid>\\S+)\\]: (?P<priority>\\S+)\\s* (?P<message>.*?)$"
	}

	stage.timestamp {
		source = "time"
		format = "2006-01-02 15:04:05,000"
	}

	stage.labels {
		values = {
			component = null,
			priority  = null,
		}
	}

	stage.output {
		source = "message"
	}

	stage.match {
		selector = "{job=\"fail2ban\"} |~ \"\\\\\\\\[\\\\\\\\S+\\\\\\\\] .*\""

		stage.regex {
			expression = "(\\[(?P<jail>\\S+)\\] )?(?P<message>.*?)$"
		}

		stage.labels {
			values = {
				jail = null,
			}
		}

		stage.output {
			source = "message"
		}
	}

	stage.label_drop {
		values = ["filename"]
	}
}

loki.source.file "fail2ban" {
	targets               = local.file_match.fail2ban.targets
	forward_to            = [loki.process.fail2ban.receiver]
	legacy_positions_file = "/tmp/positions.yaml"
}

loki.write "default" {
	endpoint {
		url = "http://loki:3100/loki/api/v1/push"
	}
	external_labels = {}
}

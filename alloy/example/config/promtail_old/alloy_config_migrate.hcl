local.file_match "modsec" {
	path_targets = [{
		__address__ = "localhost",
		__path__    = "/var/log/httpd/modsec_audit.log",
		job         = "modsec",
	}]
}

loki.process "modsec" {
	forward_to = [loki.write.default.receiver]

	stage.tenant {
		value = "sysmid-sensitive"
	}

	stage.json {
		expressions = {
			request = "transaction",
		}
	}

	stage.json {
		expressions = {
			headers = "request",
		}
	}

	stage.json {
		expressions = {
			Host = "headers",
		}
	}

	stage.labels {
		values = {
			Host = null,
		}
	}
}

loki.source.file "modsec" {
	targets               = local.file_match.modsec.targets
	forward_to            = [loki.process.modsec.receiver]
	legacy_positions_file = "/tmp/positions.yaml"
}

loki.write "default" {
	endpoint {
		url = "http://localhost:3100/loki/api/v1/push"
	}
	external_labels = {}
}

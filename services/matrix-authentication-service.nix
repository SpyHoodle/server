{ config, domains, ...}:

{
	services.matrix-authentication-service = {
		enable = true;
		createDatabase = true;
		settings = {
			http = {
				public_base = "https://${domains.auth}/";
				issuer = "https://${domains.auth}/";
			};
			email = {
				from = "'Authentication Service' <revisionappdev@gmail.com>";
				reply_to = "'Authentication Service' <revisionappdev@gmail.com>";
				transport = "smtp";
				hostname = "smtp.gmail.com";
				mode = "starttls";
				username = "revisionappdev@gmail.com";
			};
			account = {
				password_recovery_enabled = true;
			};
			matrix = {
				homeserver = "${domains.root}";
				endpoint = "http://[::1]:8008/";
			};
		};
		extraConfigFiles = [ config.age.secrets.matrix-authentication-service.path ];
	};
}

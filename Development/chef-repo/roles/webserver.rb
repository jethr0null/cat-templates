
name "webserver"
description "Web Server"
run_list "role[base]", "recipe[apache]"
default_attributes({
	"apache" => {
		"sites" => {
			"admin" => {
				"port" => 82
			},
			"bears" => {
				"port" => 8081
			}
			}
	}
}
		  )



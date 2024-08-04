role_name="my_nginx_role"

# Create the main role directory
mkdir -p "$role_name/tasks"
mkdir -p "$role_name/templates"
mkdir -p "$role_name/defaults"
mkdir -p "$role_name/handlers"
mkdir -p "$role_name/meta"

touch "$role_name/tasks/main.yml"
touch "$role_name/templates/nginx.conf.j2"
touch "$role_name/defaults/main.yml"
touch "$role_name/handlers/main.yml"
touch "$role_name/meta/main.yml"

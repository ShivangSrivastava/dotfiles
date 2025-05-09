
tom(){
    if [[ -z "$(rg tomlscript pyproject.toml )" ]]; then
        echo -e "\n[tool.tomlscript]"\
            "\n# runserver"\
            "\ndev = \"uv run manage.py runserver\""\
            "\n# manage.py"\
            "\nmanage = \"uv run manage.py\""\
            "\n# makemigrations and migrate"\
            "\nmigrate = \"uv run manage.py makemigrations && uv run manage.py migrate\""\
            "\n# startapp"\
            "\nstartapp = \"uv run manage.py startapp\"">> pyproject.toml
    fi
    uvx tomlscript "$@"
}

# Dockerized Odoo Development Environment

This project is based on [docker-odoo-dev](https://github.com/mjavint/docker-odoo-dev) from @mjavint

This is a project template to develop custom modules using an Odoo dockerized image which allow to perform remote debugging.

## Setup development environment

We need to build a custom docker image based on Odoo 17 which do the following:

* Install `debugpy` and `pydevd-odoo` dependencies.
* Creates a custom `entrypoint.sh` that enables remote debugging in port `8888`

To build image we can execute shell script: `build-image.sh` or we can execute the docker command: 

```
docker build -f docker/Dockerfile -t odoo-dev:17 .
```

In the project root directory

*Note*: In the file `requirements.txt` we can add all the dependencies that we want to include in our Odoo dev image.

## Start development environment

A `docker-compose.yml` file is included in `docker` folder. Once this compose file is initiated, the development environment is ready to work.

### Configuration

The compose file can be configured by setting values to a set of predifined environment variables. In order to set this variables a file named `.env` needs to be created in the `docker` folder and then set all the variables to properly configure the environment.

#### Postgres

The database is expected to be running outside of the compose file.

`PG_HOST`: Host where postgres database is being executed

`PG_USER`: Database user (which create db role enabled)

`PG_PASSWORD`: Database password

`PG_PORT`: Database port

#### Odoo

`ODOO_SOURCE_DIR`: Directory where odoo sources are stored (necessary for debugging).

`ODOO_CONF_DIR`: Odoo configuration file, by default a basic configuration file is provided in the project.

#### Modules

Since modules or addons could be located in different directories.

`CUSTOM_ADDONS_DIR`: Directoy where custom modules are stored (the ones that we want to develop).

`EXTRA_ADDONS_DIR`: Directory where extra addons are located.

`ADDONS_DIR`: Directory where addons are located.

## Autocomplete

In order to enable autocomplete feature for custom modules this project uses [odoo-stubs](https://github.com/odoo-ide/odoo-stubs) projects which needs to be cloned and added to the project workspace.

Also, the following file needs to be added in the project root: `pyrightconfig.json`, which is used to configure `odoo-stubs`. The file structure should be as follows:

```
{
    "stubPath": "<path where odoo-stubs was cloned>",
    "extraPaths": [
        "<path where Odoo sources are located>",
        "<path where Odoo addons are located>",
        "<path where custom addons (custom modules) are located>"
    ]
}
```

## Remote debugging

In order to be able to debug modules sources we just need to add the following `launch.json` file for Python configuraion.

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Remote Attach",
            "type": "python",
            "request": "attach",
            "connect": {
                "host": "localhost",
                "port": 8888
            },
            "pathMappings": [
                {
                    "localRoot": "<path where custom module is located>",
                    "remoteRoot": "<path where the custom module is located inside the container>"
                },
                {
                    "localRoot": "<path where odoo sources are located>",
                    "remoteRoot": "<path where odoo sources are located inside the container (usually: /var/lib/odoo/odoo)>"
                }
            ],
            "justMyCode": true
        }
    ]
}
```

## Utility Scripts

To start / restart development environment the script: `start-environment.sh` could be executed.

To stop development environment the script: `stop-environment.sh` could be executed.

If you prefer to execute the docker commands:

* `docker compose -f docker/docker-compose.yml up -d` to start / restart environment
* `docker compose -f docker/docker-compose.yml down` to stop environment
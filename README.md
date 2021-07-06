## Docker Lamp

Linux Apache MySQL PHP Server Application based on Docker.  This utility is sufficient to run a web server on a ubuntu based hosting server.

## Build 

    - cd src
    - Check the "build_config.sh" file before building
    - ./build.sh

## Docker Application Location

    - cd bin/
    - unzip vikilabs_lamp.zip
    - cd vikilabs_lamp
    - Check the "app_config.sh" file before installing app
    - ./install_app.sh
    - ./run_app.sh


## Installer Configuration 

    - app_config.sh
    - db_config.sh

## Importing DB and Code from backup

    - cd bin/vikilabs_lamp/import_utils
    - Check the "db_config.sh" file before importing db
    - ./import_db.sh
    - Check the "app_config.sh" file before importing code
    - ./import_code.sh


## App Code and Data Location

    - cd bin/vikilabs_lamp/
    - cd app_root/app

## Docker App Startup Script Location 

    - cd bin/vikilabs_lamp/app_root/startup
    - startup.sh
   


# Contacts API

```
Ruby version =====> 2.6.6
DB Engine ========> PostgreSQL
```
## Install Dependencies

```
$ gem install bundler

$ bundle install
```
<br/>

## Using Environment Variables

If you wanna connect to db using environment variables, please follow these instructions:

1. Create a env.example copy
2. Rename the copy as `.env`
3. Install dotenv gem =====> `$ gem install dotenv`
<br/>
<br/>

## Using database.yml

If you wanna connect to db using database.yml, please follow these instructions:

1. open `config/database.yml` file
2. comment these lines

    ```
    development:
        <<: *default
        url: <%= ENV['DB_DATABASE_URL'] %>
    ```

    and uncomment these lines and replace all the `db_name, db_user, db_pass, db_host, db_port` with your database information:

    ```
    # development:
    #   <<: *default
    #   database: db_name
    #   username: db_user
    #   password: db_pass
    #   host: db_host
    #   port: db_port
    ```

## Create Database (Only for first run)

Create your database if does not already exists

```
$ rails db:create
```

## Run Migrations (Try always you want to start the server)

* If you are using database.yml please run:

    ```
    $ rails db:migrate && rails s
    ```

* If you are using environment vars please run:

    ```
    $ rails db:migrate && dotenv rails s
    ```

# Contacts API - Endpoints

```
Remote API: https://koombeatest.herokuapp.com
Remote Database URI: postgres://postgres:KoombeaTest123@db.rsassquxrgbvpehcljcd.supabase.co:6543/postgres

Local API: http://localhost:3000

Test remote user: user_apiguard
Test remote password: api_password

# Test remote user and password only works for Remote API or localhost with remote database uri configuration
```

1. healthcheck: GET `/api/v1/health_check`
2. signin: POST `/api/v1/users/sign_up`
    ```
        {
            "username": string,
            "password": string,
            "password_confirmation": string,
        }
    ```
3. login: POST `/api/v1/users/sign_in`
    ```
        {
            "username": string,
            "password": string
        }
    ```
4. refresh_token: POST `/api/v1/users/tokens`
    ```
        HEADERS
            Access-Token
            Refresh-Token
    ```
5. save_csv: POST `/api/v1/contacts/import`
    ```
        HEADERS
            Access-Token
        BODY
        {
            "document": csv file,
            "name": string,
            "fields_order": comma separated string,; i.e. "name,birthday,telephone,address,credit_card,email"
        }
    ```
6. get_contacts: GET `/api/v1/contacts?page=<number>&email=<string>`
    ```
        HEADERS
            Access-Token
    ```
7. get_contact: GET `/api/v1/contacts/detail/<number>`
    ```
        HEADERS
            Access-Token
    ```
8. get_failed_contacts: GET `/api/v1/contacts/failed/logs?page=<number>`
    ```
        HEADERS
            Access-Token
    ```
8. get_uploaded_files: GET `/api/v1/contacts/import/files?page=<number>&status=<string>`
    ```
        HEADERS
            Access-Token
    ```

# Contacts API - Tasks

In case you want to run the file processing manually you can run:

```
$ rake doc_processor:save_contacts
```


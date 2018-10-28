# Rakuten API

## About software development

I opted for the choice of having a single table in the database, responsible for storing the data concerning the requisition distance. For the calculation of cost I prefer to leave in memory returning only the result / success. \
To calculate the distance between points use part of the Dijkstra library (https://github.com/thinkphp/dijkstra.gem).

## How to Run?

### Requirements
* Ruby 2.5.3 and PostgreSQL
* Docker


### Usage
With Docker:

```
$ docker-compose up
$ docker-compose run web rails db:create db:migrate
```

Without Docker:
```
$ bundle install
$ rails db:create db:migrate
$ rails s
```

## Tests
The tests were done using the Minitest.

### How to Run?
With Docker:

```
$ docker-compose run web rails test
```

Without Docker:
```
$ rails test
```

## API Documentation

### Distance:
```
POST /api/v1/distance
A B 10
```
If success will return:
```
{
    "status": "Success",
    "message": "Distance created or updated with success",
    "data": {
        "origin": "A",
        "destination": "B",
        "distance": "10.0"
    }
}
```

If something went wrong some errors will return like:
```
POST /api/v1/distance
A B F
```
```
{
    "status": "Error",
    "message": "Some params are invalid",
    "data": "A B F"
}
```
```
POST /api/v1/distance
```
```
{
    "status": "Error",
    "message": "There are no params",
    "data": ""
}
```
```
POST /api/v1/distance
A B 10 F
```
```
{
    "status": "Error",
    "message": "Amount of parameters are invalid",
    "data": "A B 10 F"
}
```
### Cost:
```
GET /api/v1/cost?origin=A&destination=C&weight=5
```
If success will return:
```
18.75
```
If something went wrong some errors will return like:
```
GET /api/v1/cost?origin=A&destination=C&weight=999999
```
```
{
    "status": "Error",
    "message": "Weight is invalid",
    "data": {
        "origin": "A",
        "destination": "C",
        "weight": "999999",
        "controller": "api/v1/costs",
        "action": "value"
    }
}
```
```
GET /api/v1/cost?origin=A&destination=C&weight=
```
```
{
    "status": "Error",
    "message": "Amount of parameters are invalid",
    "data": {
        "origin": "A",
        "destination": "C",
        "weight": "",
        "controller": "api/v1/costs",
        "action": "value"
    }
}
```
```
GET /api/v1/cost?origin=Y&destination=Z&weight=50
```
```
{
    "status": "Error",
    "message": "There is no path between origin and destination",
    "data": {
        "origin": "Y",
        "destination": "Z",
        "weight": "50",
        "controller": "api/v1/costs",
        "action": "value"
    }
}
```

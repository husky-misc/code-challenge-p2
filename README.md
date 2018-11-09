# Husky dev Ruby challenge Season 2

### Description and general information

This API receives a list of integers, performs a number of right circular rotation and returns the value of the element at a given index. One rotation operation moves the last array element to the first position and shifts all remaining elements right one.

### Dependencies

- MongoDB

### First setup

- Clone the repository

` git clone https://github.com/sarahraquel/code-challenge-p2.git && cd code-challenge-p2`

- Install the dependencies

` bundle install `

- Run the application 

` rails s `

- Run the tests

` rspec `


### Endpoints

For example, request-1 may store these data:
```
curl -i -X POST "http://localhost:3000/api/v1/store" \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
  "input": [
      "1 2 3 4: 1,3",
      "1 2 3 5: 0,0"
  ]
}'
```

At this point, if you request `/compute`, the JSON return will have the data:
```
data: {
  "result": [1,1]
}
```

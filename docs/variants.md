## Variant

A split variant

#### Relationships

- Has many SplitUserVariants
- Belongs to Split

#### Attributes

| Attribute | Type   | Description |
| :-------- | :----- | :---------- |
| `name`    | String | A descriptive name |
| `value`   | JSON   | The content |


### API

#### GET /variants

- Scoped by project owner or collaborator roles
- Site admins can access all variants
- Filterable by `project_id`, `key`, and `state`

``` json
{
  "data": [{
    "id": "1",
    "type": "variants",
    "attributes": {
      "name": "Original",
      "value": {
        "description": "Original project description"
      },
      "split_id": 1
    },
    "links": {
      "self": "/variants/1",
      "split": "/splits/1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  },
  "links": {
    "self": "/variants?page[number]=1&page[size]=1",
    "next": "/variants?page[number]=2&page[size]=1",
    "last": "/variants?page[number]=123&page[size]=1"
  }
}
```

#### GET /variants/:id

- Publicly accessible

``` json
{
  "data": [{
    "id": "1",
    "type": "variants",
    "attributes": {
      "name": "Original",
      "value": {
        "description": "Original project description"
      },
      "split_id": 1
    },
    "links": {
      "self": "/variants/1",
      "split": "/splits/1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  }
}
```

#### POST /variants

- Accessible by project owners, collaborators, and site admins

##### Schema

``` json
{
  "properties": {
    "data": {
      "properties": {
        "split_id": {
          "oneOf": [{
            "type": "integer",
            "minimum": 1
          }, {
            "type": "string",
            "pattern": "^[1-9]\\d*$"
          }]
        },
        "name": {
          "type": "string"
        },
        "value": {
          "properties": {},
          "type": "object",
          "additionalProperties": true
        }
      },
      "type": "object",
      "required": ["split_id", "name", "value"],
      "additionalProperties": false
    }
  },
  "type": "object",
  "required": ["data"]
}
```

##### Example

``` json
{
  "data": {
    "attributes": {
      "name": "Original",
      "value": {
        "description": "Original project description"
      }
    },
    "relationships": {
      "split": {
        "data": {
          "type": "splits",
          "id": "1"
        }
      }
    }
  }
}
```

#### PUT /variants/:id

- Accessible by project owners, collaborators, and site admins

##### Schema

``` json
{
  "properties": {
    "data": {
      "properties": {
        "split_id": {
          "oneOf": [{
            "type": "integer",
            "minimum": 1
          }, {
            "type": "string",
            "pattern": "^[1-9]\\d*$"
          }]
        },
        "name": {
          "type": "string"
        },
        "value": {
          "properties": {},
          "type": "object",
          "additionalProperties": true
        }
      },
      "type": "object",
      "additionalProperties": false
    }
  },
  "type": "object",
  "required": ["data"]
}
```

##### Example

``` json
{
  "data": {
    "attributes": {
      "value": {
        "description": "Better project description"
      }
    }
  }
}
```

#### DELETE /variants/:id

- Accessible by project owners, collaborators, and site admins

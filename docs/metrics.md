## Metric

The record of a user event

#### Relationships

- Belongs to SplitUserVariant

#### Attributes

| Attribute | Type   | Description |
| :-------- | :----- | :---------- |
| `key`     | String | An identifier of the user event |
| `value`   | JSON   | Extra information for the event |

### API

<details>
<summary>
#### GET /metrics
</summary>

- Scoped by project owner or collaborator roles
- Site admins can access all metrics
- Filterable by `key` and `split_user_variant_id`

``` json
{
  "data": [{
    "id": "1",
    "type": "metrics",
    "attributes": {
      "key": "classification_created",
      "value": {
        "classification_id": "123456"
      },
      "split_user_variant_id": "1",
      "created_at": "2016-11-02T12:00:00Z"
    },
    "links": {
      "self": "/metrics/1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  },
  "links": {
    "self": "/metrics?page[number]=1&page[size]=1",
    "next": "/metrics?page[number]=2&page[size]=1",
    "last": "/metrics?page[number]=123&page[size]=1"
  }
}
```
</details>

<details>
<summary>
#### GET /metrics/:id
</summary>

- Scoped by project owner or collaborator roles
- Site admins can access all metrics

``` json
{
  "data": [{
    "id": "1",
    "type": "metrics",
    "attributes": {
      "key": "classification_created",
      "value": {
        "classification_id": "123456"
      },
      "split_user_variant_id": "1",
      "created_at": "2016-11-02T12:00:00Z"
    },
    "links": {
      "self": "/metrics/1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  }
}
```
</details>

<details>
<summary>
#### POST /metrics
</summary>

- Accessible by project owners, collaborators, and site admins

##### Schema

``` json
{
  "properties": {
    "data": {
      "properties": {
        "split_user_variant_id": {
          "oneOf": [{
            "type": "integer",
            "minimum": 1
          }, {
            "type": "string",
            "pattern": "^[1-9]\\d*$"
          }]
        },
        "key": {
          "type": "string"
        },
        "value": {
          "properties": {},
          "type": "object",
          "additionalProperties": true
        }
      },
      "type": "object",
      "required": ["split_user_variant_id", "key", "value"],
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
      "key": "classification_created",
      "value": {
        "classification_id": "123456"
      }
    },
    "relationships": {
      "split_user_variants": {
        "data": {
          "type": "split_user_variants",
          "id": "1"
        }
      }
    }
  }
}
```
</details>

<details>
<summary>
#### PUT /metrics/:id
</summary>

- Not permitted
</details>

<details>
<summary>
#### DELETE /metrics/:id
</summary>

- Not permitted
</details>

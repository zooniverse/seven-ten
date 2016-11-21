## Split

The A/B split test

#### Relationships

- Has many Variants
- Has many DataRequests
- Belongs to Project

#### Attributes

| Attribute    | Type      | Description |
| :----------- | :-------- | :---------- |
| `name`       | String    | A descriptive name |
| `key`        | String    | An identifier for the type of split |
| `state`      | String    | The activated state: 'inactive', 'active', 'complete' |
| `starts_at`  | Date time | An optional time for the split to activate |
| `ends_at`    | Date time | An optional time for the split to complete |

Supported split keys are currently

- `'landing.text'`
- `'workflow.assignment'`
- `'workflow.advance'`
- `'mini-course.visible'`

### API

<details>
<summary><strong>GET /splits</strong></summary>

- Scoped by project owner or collaborator roles
- Site admins can access all splits
- Filterable by `project_id`, `key`, and `state`

``` json
{
  "data": [{
    "id": "1",
    "type": "splits",
    "attributes": {
      "name": "Landing text",
      "key": "landing.text",
      "state": "active",
      "project_id": 1,
      "metric_types": ["classifier_visited", "classification_created"],
      "ends_at": "2016-11-16T12:00:00Z",
      "created_at": "2016-11-02T12:00:00Z",
      "updated_at": "2016-11-02T12:00:00Z"
    },
    "links": {
      "self": "/splits/1",
      "variants": "/variants?filter[split_id]=1",
      "data_requests": "/data_requests?filter[split_id]=1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  },
  "links": {
    "self": "/splits?page[number]=1&page[size]=1",
    "next": "/splits?page[number]=2&page[size]=1",
    "last": "/splits?page[number]=123&page[size]=1"
  }
}
```
</details>

<details>
<summary><strong>GET /splits/:id</strong></summary>

- Publicly accessible

``` json
{
  "data": [{
    "id": "1",
    "type": "splits",
    "attributes": {
      "name": "Landing text",
      "key": "landing.text",
      "state": "active",
      "project_id": 1,
      "metric_types": ["classifier_visited", "classification_created"],
      "ends_at": "2016-11-16T12:00:00Z",
      "created_at": "2016-11-02T12:00:00Z",
      "updated_at": "2016-11-02T12:00:00Z"
    },
    "links": {
      "self": "/splits/1",
      "variants": "/variants?filter[split_id]=1",
      "data_requests": "/data_requests?filter[split_id]=1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  }
}
```
</details>

<details>
<summary><strong>POST /splits</strong></summary>

- Accessible by project owners, collaborators, and site admins

##### Schema

``` json
{
  "properties": {
    "data": {
      "properties": {
        "project_id": {
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
        "key": {
          "type": "string"
        },
        "state": {
          "enum": ["inactive", "active", "complete"]
        },
        "starts_at": {
          "type": "string",
          "format": "date-time"
        },
        "ends_at": {
          "type": "string",
          "format": "date-time"
        }
      },
      "type": "object",
      "required": ["project_id", "name", "key", "state"],
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
      "name": "Landing text",
      "key": "landing.text",
      "state": "inactive"
    },
    "relationships": {
      "project": {
        "data": {
          "type": "projects",
          "id": "1"
        }
      }
    }
  }
}
```
</details>

<details>
<summary><strong>PUT /splits/:id</strong></summary>

- Accessible by project owners, collaborators, and site admins

##### Schema

``` json
{
  "properties": {
    "data": {
      "properties": {
        "project_id": {
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
        "key": {
          "type": "string"
        },
        "state": {
          "enum": ["inactive", "active", "complete"]
        },
        "starts_at": {
          "type": "string",
          "format": "date-time"
        },
        "ends_at": {
          "type": "string",
          "format": "date-time"
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
      "name": "Better landing text",
      "state": "active"
    }
  }
}
```
</details>

<details>
<summary><strong>DELETE /splits/:id</strong></summary>

- Accessible by project owners, collaborators, and site admins
</details>

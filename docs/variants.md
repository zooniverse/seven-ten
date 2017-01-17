## Variant

A split variant

#### Relationships

- Has many SplitUserVariants
- Belongs to Split

#### Attributes

| Attribute | Type    | Description |
| :-------- | :-----  | :---------- |
| `name`    | String  | A descriptive name |
| `value`   | JSON    | The content |
| `weight`  | Integer | The likelihood of selecting (1 - 100) |

Weighted sampling is optional.
If variants have `weight`s, they should sum to 100.
If variants do not have `weight`s, a random selection will be made.

Expected `value`s for current split keys:

- `landing.text`
  - `value: { description: 'Some text' }`
- `workflow.assignment`
  - `value: { description: 'Some text' }`
- `workflow.advance`
  - `value: { accept: 'Some text', decline: 'Some text' }`
- `mini-course.visible`
  - `value: { button: true, auto: true }` (enabled/disabled)
- `subject.first-to-classify`
  - `value: { message: 'Some text' }`

### API

<details>
<summary><strong>GET /variants</strong></summary>

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
      "weight": 50,
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
</details>

<details>
<summary><strong>GET /variants/:id</strong></summary>

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
      "weight": 50,
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
</details>

<details>
<summary><strong>POST /variants</strong></summary>

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
        },
        "weight": {
          "type": "integer",
          "minimum": 1,
          "maximum": 100
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
</details>

<details>
<summary><strong>PUT /variants/:id</strong></summary>

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
        },
        "weight": {
          "type": "integer",
          "minimum": 1,
          "maximum": 100
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
</details>

<details>
<summary><strong>DELETE /variants/:id</strong></summary>

- Accessible by project owners, collaborators, and site admins
</details>

## Project

A Panoptes project.  `Project#id` is consistent with Panoptes

#### Relationships

- Has many Splits

#### Attributes

| Attribute | Type   | Description |
| :-------- | :----- | :---------- |
| `slug`    | String | The project url slug |

### API

#### GET /projects

- Publicly accessible
- Filterable by `slug`

``` json
{
  "data": [{
    "id": "1",
    "type": "projects",
    "attributes": {
      "slug": "project-owner/project-name"
    },
    "links": {
      "self": "/projects/1",
      "splits": "/splits?filter[project_id]=1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  },
  "links": {
    "self": "/projects?page[number]=1&page[size]=1",
    "next": "/projects?page[number]=2&page[size]=1",
    "last": "/projects?page[number]=123&page[size]=1"
  }
}
```

#### GET /projects/:id

- Publicly accessible

``` json
{
  "data": [{
    "id": "1",
    "type": "projects",
    "attributes": {
      "slug": "project-owner/project-name"
    },
    "links": {
      "self": "/projects/1",
      "splits": "/splits?filter[project_id]=1"
    }
  }],
  "jsonapi": {
    "version": "1.0"
  }
}
```

#### POST /projects

- Accessible by project owners, collaborators, and site admins

##### Schema

``` json
{
  "properties": {
    "data": {
      "properties": {
        "slug": {
          "type": "string"
        }
      },
      "type": "object",
      "required": [
        "slug"
      ],
      "additionalProperties": false
    }
  },
  "type": "object",
  "required": [
    "data"
  ]
}
```

##### Example

``` json
{
  "data": {
    "type": "projects",
    "attributes": {
      "slug": "project-owner/project-name"
    }
  }
}
```

#### PUT /projects/:id

- Not permitted

#### DELETE /projects/:id

- Not permitted

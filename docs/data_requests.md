## DataRequest

A request for a Split's Metrics

#### Relationships

- Belongs to Split

#### Attributes

| Attribute | Type   | Description |
| :-------- | :----- | :---------- |
| `state`   | String | The processing state: 'pending', 'complete', 'failed' |
| `url`     | String | The url of the downloadable data export |


### API

<details>
<summary><strong>GET /data_requests</strong></summary>

- Scoped by project owner or collaborator roles
- Site admins can access all data requests
- Filterable by `split_id` and `projects.slug`
- Includes `split` by default

``` json
{
  "data": [{
    "id": "1",
    "type": "data_requests",
    "attributes": {
      "split_id": 1,
      "state": "pending",
      "url": null,
      "created_at": "2016-11-02T12:00:00Z",
      "updated_at": "2016-11-02T12:00:00Z"
    },
    "relationships": {
      "split": {
        "data": {
          "id": "1",
          "type": "splits"
        }
      }
    },
    "links": {
      "self": "/data_requests/1",
      "split": "/splits/1"
    }
  }],
  "included": [{
    "id": "1",
    "type": "splits",
    "attributes": {
      "name": "Landing text",
      "key": "landing.text",
      "state": "active",
      "project_id": "1",
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
    "self": "/data_requests?page[number]=1&page[size]=1",
    "next": "/data_requests?page[number]=2&page[size]=1",
    "last": "/data_requests?page[number]=123&page[size]=1"
  }
}
```
</details>

<details>
<summary><strong>GET /data_requests/:id</strong></summary>

- Scoped by project owner or collaborator roles
- Site admins can access all data requests
- Includes `split` by default

``` json
{
  "data": [{
    "id": "1",
    "type": "data_requests",
    "attributes": {
      "split_id": 1,
      "state": "pending",
      "url": null,
      "created_at": "2016-11-02T12:00:00Z",
      "updated_at": "2016-11-02T12:00:00Z"
    },
    "relationships": {
      "split": {
        "data": {
          "id": "1",
          "type": "splits"
        }
      }
    },
    "links": {
      "self": "/data_requests/1",
      "split": "/splits/1"
    }
  }],
  "included": [{
    "id": "1",
    "type": "splits",
    "attributes": {
      "name": "Landing text",
      "key": "landing.text",
      "state": "active",
      "project_id": "1",
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
<summary><strong>POST /data_requests</strong></summary>

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
        }
      },
      "type": "object",
      "required": ["split_id"],
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
    "attributes": {},
    "relationships": {
      "splits": {
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
<summary><strong>PUT /data_requests/:id</strong></summary>

- Not permitted
</details>

<details>
<summary><strong>DELETE /data_requests/:id</strong></summary>

- Not permitted
</details>

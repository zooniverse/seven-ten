## SplitUserVariant

The assignment of Variant to a User for a Split

#### Relationships

- Has many Metrics
- Belongs to Split
- Belongs to User
- Belongs to Variant

### API

<details>
<summary><strong>GET /split_user_variants</strong></summary>

- Scoped by current user
- Will assign the current user to a variant if:
  - filtering by `projects.slug`
  - that project has an active split
  - and the current user is not yet assigned to a variant
- Filterable by `split_id`, and `projects.slug`
- Includes `split` and `variant`

``` json
{
  "data": [{
    "id": "1",
    "type": "split_user_variants",
    "relationships": {
      "split": {
        "data": {
          "id": "1",
          "type": "splits"
        }
      },
      "variant": {
        "data": {
          "id": "1",
          "type": "variants"
        }
      }
    },
    "links": {
      "self": "/split_user_variants/1",
      "split": "/splits/1",
      "variant": "/variants/1"
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
  }, {
    "id": "1",
    "type": "variants",
    "attributes": {
      "name": "Original",
      "value": {
        "description": "Original project description"
      },
      "split_id": "1"
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
    "self": "/split_user_variants?filter[projects.slug]=project-owner/project-name&page[number]=1&page[size]=1",
    "next": "/split_user_variants?filter[projects.slug]=project-owner/project-name&page[number]=2&page[size]=1",
    "last": "/split_user_variants?filter[projects.slug]=project-owner/project-name&page[number]=123&page[size]=1"
  }
}
```
</details>

<details>
<summary><strong>GET /split_user_variants/:id</strong></summary>

- Publicly accessible
- Includes `split` and `variant`

``` json
{
  "data": [{
    "id": "1",
    "type": "split_user_variants",
    "relationships": {
      "split": {
        "data": {
          "id": "1",
          "type": "splits"
        }
      },
      "variant": {
        "data": {
          "id": "1",
          "type": "variants"
        }
      }
    },
    "links": {
      "self": "/split_user_variants/1",
      "split": "/splits/1",
      "variant": "/variants/1"
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
  }, {
    "id": "1",
    "type": "variants",
    "attributes": {
      "name": "Original",
      "value": {
        "description": "Original project description"
      },
      "split_id": "1"
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
<summary><strong>POST /split_user_variants</strong></summary>

- Not permitted
</details>

<details>
<summary><strong>PUT /split_user_variants/:id</strong></summary>

- Not permitted
</details>

<details>
<summary><strong>DELETE /split_user_variants/:id<strong></summary>

- Not permitted
</details>

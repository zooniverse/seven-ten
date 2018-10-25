# Setting Up a New Experiment
The API hasn't gotten a lot of attention lately, so experiments are usually set up via the Rails console.

## Creating Splits

### Project

Find or create your project with their Panoptes id and slug:

`project = Project.find(1234)`
or

`project = Project.create id: 1234, slug: 'username/a-project'`

### Split
Determine which [split key](https://github.com/zooniverse/Seven-Ten/blob/master/docs/variants.md) (see also: [the variant docs](https://github.com/zooniverse/Seven-Ten/blob/master/app/models/concerns/metric_types.rb)) you want to track, then create the split:

`split = Split.create name: 'My new split', key: "workflow.assignment", project: project`

### Variants
By default, variants weights are split evenly between however many there are. If you're A/B testing, you can leave this attribute alone and the probabilities will be 50/50. They require names ("visible"/"hidden", "blank"/"congrats", etc) and the arbitrary values that will be passed to the front end (say, a message or a div). 

```
variant1 = split.variants.create name: 'collaborative', value: {div: true}
variant2 = split.variants.create name: 'individual', value: {div: false}
```

### Timing
Finally, set the starts_at and ends_at for your experiment. It will automatically activate and deactivate at those times (in UTC). You can use text (transformed into datetimes) or any of Ruby's helper methods.

```
split.starts_at = 96.hours.from_now
split.ends_at = split.starts_at + 1.month
```
### Save and Check
Give it a bang-save and check that the split is attached to the correct project, has the variants you intended, and that the start and end dates are correct.
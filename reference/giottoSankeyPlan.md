# S4 giottoSankeyPlan class

Object to organize the sets of information to select from a Giotto
object's metadata to compare across annotations from the same or across
spatial units and feature types.

## Value

giottoSankeyPlan

## Slots

- `set_address`:

  subnesting location within Giotto object of metadata info stored as a
  data.table

- `set_subset`:

  a subset to apply upon the metadata info for a set

- `set_label`:

  character label to apply to a set

- `data_type`:

  whether the metadata is cell or feat

- `relations`:

  data.table of from and to comparisons between sets. The sets are
  referred to as zero indexed integers.

class_name ArrayHelper


# filter(element_in_source: Variant, filter_args: Array) -> bool
static func map(source: Array, filter: Callable, filter_args: Array) -> Array:
    var target: Array = []

    for i: Variant in source:
        if filter.call(i, filter_args):
            target.push_back(i)
    return target

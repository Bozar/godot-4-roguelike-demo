class_name ArrayHelper


# is_valid(element_in_source: Variant, is_valid_args: Array) -> bool
static func filter(source: Array, is_valid: Callable, is_valid_args: Array) \
        -> Array:
    var target: Array = []

    for i: Variant in source:
        if is_valid.call(i, is_valid_args):
            target.push_back(i)
    return target


# modify(element_in_source: Variant, modify_args: Array) -> Variant
static func map(source: Array, modify: Callable, modify_args: Array) -> Array:
    var target: Array = []

    for i: Variant in source:
        target.push_back(modify.call(i, modify_args))
    return target

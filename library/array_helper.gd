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


static func swap_element(source: Array, left_idx: int, right_idx: int) -> void:
    var tmp: Variant = source[left_idx]
    source[left_idx] = source[right_idx]
    source[right_idx] = tmp


static func shuffle(source: Array, rand: RandomNumber) -> void:
    var max_index: int = source.size()
    var rand_index: int

    for i: int in range(0, max_index):
        rand_index = rand.get_int(i, max_index)
        swap_element(source, i, rand_index)

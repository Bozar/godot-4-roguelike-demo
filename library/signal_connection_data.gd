class_name SignalConnectionData


const INIT_WORLD: String = "InitWorld"
const SPRITE_ROOT: String = "SpriteRoot"
const SPRITE_STATE: String = "SpriteState"


const SIGNAL_SPRITES_CREATED: String = "sprites_created"


# {source_node: {signal_name: [target_node_1, ...]}, ...}
const SIGNAL_CONNECTIONS: Dictionary = {
    INIT_WORLD: {
        SIGNAL_SPRITES_CREATED: [
            SPRITE_ROOT, SPRITE_STATE,
        ],
    },
}

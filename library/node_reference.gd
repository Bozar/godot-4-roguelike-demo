class_name NodeReference


const SPRITE_ROOT: String = "SpriteRoot"
const SPRITE_STATE: String = "SpriteState"
const PLAYER_INPUT: String = "PlayerInput"
const PC_ACTION: String = "PcAction"
const SIDEBAR: String = "Sidebar"
const SCHEDULE: String = "Schedule"
const RANDOM_NUMBER: String = "RandomNumber"
const ACTOR_ACTION: String = "ActorAction"
const FOOTNOTE_LABEL: String = "Sidebar/SidebarVBox/FootnoteLabel"
const GAME_STATE_LABEL: String = "Sidebar/SidebarVBox/GameStateLabel"

const SEARCH_HELPER: String = "/root/SpriteStateHelper"
const MOVE_SPRITE: String = "/root/MoveSprite"
const SPRITE_FACTORY: String = "/root/SpriteFactory"

const SIGNAL_SPRITE_CREATED: String = "sprite_created"
const SIGNAL_SPRITE_REMOVED: String = "sprite_removed"

const SIGNAL_SPRITE_MOVED: String = "sprite_moved"
const SIGNAL_SPRITE_SWAPPED: String = "sprite_swapped"
const SIGNAL_ACTION_PRESSED: String = "action_pressed"

const SIGNAL_TURN_STARTED: String = "turn_started"


# {source_node: [target_node_1, ...], ...}
const NODE_CONNECTIONS: Dictionary = {
    ACTOR_ACTION: [
        PC_ACTION,
    ],
    RANDOM_NUMBER: [
        FOOTNOTE_LABEL, ACTOR_ACTION,
    ],
    PC_ACTION: [
        GAME_STATE_LABEL, ACTOR_ACTION,
    ],
    SCHEDULE: [
        PC_ACTION, ACTOR_ACTION,
    ],
    SPRITE_STATE: [
        SEARCH_HELPER,
    ],
}


# {source_node: {signal_name: [target_node_1, ...]}, ...}
const SIGNAL_CONNECTIONS: Dictionary = {
    PLAYER_INPUT: {
        SIGNAL_ACTION_PRESSED: [
            PC_ACTION,
        ],
    },
    MOVE_SPRITE: {
        SIGNAL_SPRITE_MOVED: [
            SPRITE_STATE,
        ],
        SIGNAL_SPRITE_SWAPPED: [
            SPRITE_STATE,
        ],
    },
    SPRITE_FACTORY: {
        SIGNAL_SPRITE_CREATED: [
            SPRITE_ROOT, SPRITE_STATE, PC_ACTION, SCHEDULE, ACTOR_ACTION,
        ],
        SIGNAL_SPRITE_REMOVED: [
            SPRITE_ROOT, SPRITE_STATE, SCHEDULE, ACTOR_ACTION,
        ],
    },
    SCHEDULE: {
        SIGNAL_TURN_STARTED: [
            PLAYER_INPUT, SIDEBAR, PC_ACTION, ACTOR_ACTION,
        ],
    },
}

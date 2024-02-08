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

const SEARCH_HELPER: String = "/root/SearchHelper"
const MOVE_SPRITE: String = "/root/MoveSprite"
const SPRITE_FACTORY: String = "/root/SpriteFactory"

const SIGNAL_SEARCHING_BY_TAG: String = "searching_by_tag"
const SIGNAL_SEARCHING_BY_COORD: String = "searching_by_coord"
const SIGNAL_SEARCHING_BY_COORD_TAG: String = "searching_by_coord_tag"
const SIGNAL_SEARCHING_BY_ID: String = "searching_by_id"

const SIGNAL_SEARCHING_PC_ACTION: String = "searching_pc_action"
const SIGNAL_SEARCHING_RANDOM_NUMBER: String = "searching_random_number"

const SIGNAL_SPRITE_CREATED: String = "sprite_created"
const SIGNAL_SPRITE_REMOVED: String = "sprite_removed"

const SIGNAL_SPRITE_MOVED: String = "sprite_moved"
const SIGNAL_SPRITE_SWAPPED: String = "sprite_swapped"
const SIGNAL_ACTION_PRESSED: String = "action_pressed"

const SIGNAL_TURN_ENDED: String = "turn_ended"
const SIGNAL_TURN_STARTED: String = "turn_started"


# {source_node: [target_node_1, ...], ...}
const NODE_CONNECTIONS: Dictionary = {
    ACTOR_ACTION: [
        PC_ACTION,
    ],
    RANDOM_NUMBER: [
        FOOTNOTE_LABEL,
    ],
    PC_ACTION: [
        GAME_STATE_LABEL,
    ],
    SCHEDULE: [
        PC_ACTION, PLAYER_INPUT,
    ],
}


# {source_node: {signal_name: [target_node_1, ...]}, ...}
const SIGNAL_CONNECTIONS: Dictionary = {
    PLAYER_INPUT: {
        SIGNAL_ACTION_PRESSED: [
            PC_ACTION,
        ],
    },
    SEARCH_HELPER: {
        SIGNAL_SEARCHING_BY_COORD: [
            SPRITE_STATE,
        ],
        SIGNAL_SEARCHING_BY_TAG: [
            SPRITE_STATE,
        ],
        SIGNAL_SEARCHING_BY_ID: [
            SPRITE_STATE,
        ],
        SIGNAL_SEARCHING_BY_COORD_TAG: [
            SPRITE_STATE,
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

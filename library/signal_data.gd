class_name SignalData


const SPRITE_ROOT: String = "SpriteRoot"
const SPRITE_STATE: String = "SpriteState"
const PLAYER_INPUT: String = "PlayerInput"
const PC_ACTION: String = "PcAction"
const SIDEBAR: String = "Sidebar"

const SEARCH_HELPER: String = "/root/SearchHelper"
const PC_STATE_HELPER: String = "/root/PcStateHelper"
const MOVE_SPRITE: String = "/root/MoveSprite"
const SPRITE_FACTORY: String = "/root/SpriteFactory"
const SCHEDULE_HELPER: String = "/root/ScheduleHelper"


const SIGNAL_SEARCHING_BY_TAG: String = "searching_by_tag"
const SIGNAL_SEARCHING_BY_COORD: String = "searching_by_coord"
const SIGNAL_SEARCHING_BY_COORD_TAG: String = "searching_by_coord_tag"
const SIGNAL_SEARCHING_BY_SPRITE: String = "searching_by_sprite"

const SIGNAL_SEARCHING_PC_STATE: String = "searching_pc_state"

const SIGNAL_SPRITE_CREATED: String = "sprite_created"
const SIGNAL_SPRITE_REMOVED: String = "sprite_removed"

const SIGNAL_SPRITE_MOVED: String = "sprite_moved"
const SIGNAL_SPRITE_SWAPPED: String = "sprite_swapped"
const SIGNAL_PC_MOVED: String = "pc_moved"

const SIGNAL_TURN_ENDED: String = "turn_ended"


# {source_node: {signal_name: [target_node_1, ...]}, ...}
const SIGNAL_CONNECTIONS: Dictionary = {
    PLAYER_INPUT: {
        SIGNAL_PC_MOVED: [
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
        SIGNAL_SEARCHING_BY_SPRITE: [
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
            SPRITE_ROOT, SPRITE_STATE, PC_ACTION,
        ],
        SIGNAL_SPRITE_REMOVED: [
            SPRITE_ROOT, SPRITE_STATE,
        ],
    },
    PC_STATE_HELPER: {
        SIGNAL_SEARCHING_PC_STATE: [
            SPRITE_STATE,
        ],
    },
    SCHEDULE_HELPER: {
        SIGNAL_TURN_ENDED: [
            SIDEBAR,
        ],
    },
}

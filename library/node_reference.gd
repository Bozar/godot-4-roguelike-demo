class_name NodeReference


const SPRITE_ROOT: String = "SpriteRoot"
const SPRITE_STATE: String = "SpriteState"
const PLAYER_INPUT: String = "PlayerInput"
const PC_ACTION: String = "PcAction"
const SIDEBAR: String = "Sidebar"
const SCHEDULE: String = "Schedule"
const RANDOM_NUMBER: String = "RandomNumber"
const ACTOR_ACTION: String = "ActorAction"
const GAME_PROGRESS: String = "GameProgress"
const NEW_GAME: String = "NewGame"
const INIT_WORLD: String = "InitWorld"
const SPLASH_SCREEN: String = "SplashScreen"
const FOOTNOTE_LABEL: String = "Sidebar/SidebarVBox/FootnoteLabel"
const GAME_STATE_LABEL: String = "Sidebar/SidebarVBox/GameStateLabel"

const SEARCH_HELPER: String = "/root/SpriteStateHelper"
const SPRITE_FACTORY: String = "/root/SpriteFactory"

const SIGNAL_SPRITE_CREATED: String = "sprite_created"
const SIGNAL_SPRITE_REMOVED: String = "sprite_removed"

const SIGNAL_SPRITE_MOVED: String = "sprite_moved"
const SIGNAL_SPRITE_SWAPPED: String = "sprite_swapped"
const SIGNAL_ACTION_PRESSED: String = "action_pressed"
const SIGNAL_GAME_OVER: String = "game_over"

const SIGNAL_TURN_STARTED: String = "turn_started"


# {source_node: [target_node_1, ...], ...}
const NODE_CONNECTIONS: Dictionary = {
    ACTOR_ACTION: [
        PC_ACTION,
    ],
    RANDOM_NUMBER: [
        FOOTNOTE_LABEL, ACTOR_ACTION, NEW_GAME,
    ],
    PC_ACTION: [
        GAME_STATE_LABEL, ACTOR_ACTION,
    ],
    SCHEDULE: [
        PC_ACTION, ACTOR_ACTION, NEW_GAME,
    ],
    SPRITE_STATE: [
        SEARCH_HELPER, PC_ACTION, ACTOR_ACTION,
    ],
    GAME_PROGRESS: [
        PC_ACTION, ACTOR_ACTION,
    ],
    INIT_WORLD: [
        NEW_GAME,
    ],
    SIDEBAR: [
        NEW_GAME,
    ],
}


# {source_node: {signal_name: [target_node_1, ...]}, ...}
const SIGNAL_CONNECTIONS: Dictionary = {
    PLAYER_INPUT: {
        SIGNAL_ACTION_PRESSED: [
            PC_ACTION, NEW_GAME, SPLASH_SCREEN,
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
    GAME_PROGRESS: {
        SIGNAL_GAME_OVER: [
            SCHEDULE, PC_ACTION, PLAYER_INPUT, SIDEBAR,
        ],
    },
}

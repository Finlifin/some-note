### **Scheduling**:
---
$$
\Large Stages \leftarrow Systems\leftarrow Commands
$$

>By default, when you add your systems, they are added to `CoreStage::Update`. Startup systems are added to `StartupStage::Startup`.

- **启动时执行:**
>In the main_app (StartupStage, run once at app startup): PreStartup, Startup, PostStartup

- **帧执行:**
>In the main app (CoreStage, run every frame update): First, PreUpdate, Update, PostUpdate, Last

    All systems to be run by Bevy are contained in stages. Every frame update, Bevy executes each stage, in order. Within each stage, Bevy's scheduling algorithm can run many systems in parallel, using multiple CPU cores for good performance.

- **In Rendering:**
>In the render sub-app (RenderStage): Extract, Prepare, Queue, PhaseSort, Render, Cleanup

- **定时任务:**

- **异步处理:**

- **自定义stage：**

You can add your own additional stages. For example, if we want our debug systems to run after our game logic:
```rust
fn main() {
    // label for our debug stage
    static DEBUG: &str = "debug";

    App::new()
        .add_plugins(DefaultPlugins)

        // add DEBUG stage after Bevy's Update
        // also make it single-threaded
        .add_stage_after(CoreStage::Update, DEBUG, SystemStage::single_threaded())

        // systems are added to the `CoreStage::Update` stage by default
        .add_system(player_gather_xp)
        .add_system(player_take_damage)

        // add our debug systems
        .add_system_to_stage(DEBUG, debug_player_hp)
        .add_system_to_stage(DEBUG, debug_stats_change)
        .add_system_to_stage(DEBUG, debug_new_hostiles)

        .run();
}

```
- **Note then stage is the only way to apply commands.**

### **Global Resouse**:
---

**Just simply derive the Resource trait to label a global state:**
```rust
#[derive(Resource)]
struct GoalsReached {
    main_goal: bool,
    bonus: bool,
}
```
- Note the resource is a **singleton instance** in a app

**For resources that need complex initialization, implement FromWorld:**

```rust
#[derive(Resource)]
struct MyFancyResource { /* stuff */ }

impl FromWorld for MyFancyResource {
    fn from_world(world: &mut World) -> Self {
        // You have full access to anything in the ECS from here.
        // For instance, you can mutate other resources:
        let mut x = world.get_resource_mut::<MyOtherResource>().unwrap();
        x.do_mut_stuff();

        MyFancyResource { /* stuff */ }
    }
}
```

### **Components Attachment**:
---

### **Entity Iteration**:
---

### **Command Execution:**
---
**Use Commands to spawn/despawn entities, add/remove components on existing entities, manage resources.**
```rust
fn spawn_things(
    mut commands: Commands,
) {
    // manage resources
    commands.insert_resource(GoalsReached { main_goal: false, bonus: false });
    commands.remove_resource::<MyResource>();

    // create a new entity using `spawn`,
    // providing the data for the components it should have
    // (typically using a Bundle)
    commands.spawn(PlayerBundle {
        name: PlayerName("Henry".into()),
        xp: PlayerXp(1000),
        health: Health {
            hp: 100.0, extra: 20.0
        },
        _p: Player,
        sprite: Default::default(),
    });

    // you can use a tuple if you need additional components or bundles
    // (tuples of component and bundle types are considered bundles)
    // (note the extra parentheses)
    let my_entity_id = commands.spawn((
        // add some components
        ComponentA,
        ComponentB::default(),
        // add some bundles
        MyBundle::default(),
        TransformBundle::default(),
    )).id(); // get the Entity (id) by calling `.id()` at the end

    // add/remove components of an existing entity
    commands.entity(my_entity_id)
        .insert(ComponentC::default())
        .remove::<ComponentA>()
        .remove::<(ComponentB, MyBundle)>();
}

fn make_all_players_hostile(
    mut commands: Commands,
    // we need the Entity id, to perform commands on specific entities
    query: Query<Entity, With<Player>>,
) {
    for entity in query.iter() {
        commands.entity(entity)
            // add an `Enemy` component to the entity
            .insert(Enemy)
            // remove the `Friendly` component
            .remove::<Friendly>();
    }
}

fn despawn_all_enemies(
    mut commands: Commands,
    query: Query<Entity, With<Enemy>>,
) {
    for entity in query.iter() {
        commands.entity(entity).despawn();
    }
}
```
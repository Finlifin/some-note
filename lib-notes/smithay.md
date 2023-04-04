# **backend**：提供操作系统相关交互接口
**backend::input::InputEvent**:可由输入后端产生的不同事件
```rust
pub enum InputEvent<B: InputBackend> {
    DeviceAdded {
        device: B::Device,
    },
    DeviceRemoved {
        device: B::Device,
    },
    Keyboard {
        event: B::KeyboardKeyEvent,
    },
    PointerMotion {
        event: B::PointerMotionEvent,
    },
    PointerMotionAbsolute {
        event: B::PointerMotionAbsoluteEvent,
    },
    PointerButton {
        event: B::PointerButtonEvent,
    },
    PointerAxis {
        event: B::PointerAxisEvent,
    },
    TouchDown {
        event: B::TouchDownEvent,
    },
    TouchMotion {
        event: B::TouchMotionEvent,
    },
    TouchUp {
        event: B::TouchUpEvent,
    },
    TouchCancel {
        event: B::TouchCancelEvent,
    },
    TouchFrame {
        event: B::TouchFrameEvent,
    },
    TabletToolAxis {
        event: B::TabletToolAxisEvent,
    },
    TabletToolProximity {
        event: B::TabletToolProximityEvent,
    },
    TabletToolTip {
        event: B::TabletToolTipEvent,
    },
    TabletToolButton {
        event: B::TabletToolButtonEvent,
    },
    Special(B::SpecialEvent),
}
```

**backend::input::InputBackend**：描述提供输入事件来源的对象的特质。所有的输入后端都需要实现这一点，并对给定事件的精度提供相同的基础保证。

```rust
pub trait InputBackend: Sized {
    type EventError: Error;
    type Device: Device;
    type KeyboardKeyEvent: KeyboardKeyEvent<Self>;
    type PointerAxisEvent: PointerAxisEvent<Self>;
    type PointerButtonEvent: PointerButtonEvent<Self>;
    type PointerMotionEvent: PointerMotionEvent<Self>;
    type PointerMotionAbsoluteEvent: PointerMotionAbsoluteEvent<Self>;
    type TouchDownEvent: TouchDownEvent<Self>;
    type TouchUpEvent: TouchUpEvent<Self>;
    type TouchMotionEvent: TouchMotionEvent<Self>;
    type TouchCancelEvent: TouchCancelEvent<Self>;
    type TouchFrameEvent: TouchFrameEvent<Self>;
    type TabletToolAxisEvent: TabletToolAxisEvent<Self>;
    type TabletToolProximityEvent: TabletToolProximityEvent<Self>;
    type TabletToolTipEvent: TabletToolTipEvent<Self>;
    type TabletToolButtonEvent: TabletToolButtonEvent<Self>;
    type SpecialEvent;
    fn dispatch_new_events<F>(
        &mut self,
        callback: F
    ) -> Result<(), Self::EventError>
    where
        F: FnMut(InputEvent<Self>);
}

```

**backend::input::KeyboadKeyEvent**：Trait for keyboard event
```rust
pub trait KeyboardKeyEvent<B: InputBackend>: Event<B> {
    fn key_code(&self) -> u32;
    fn state(&self) -> KeyState;
    fn count(&self) -> u32;
}
```
**backend::render::gles2::Gles2Render**

**backend::render::Frame**

**backend::render::Render**
use crate::frb_generated::StreamSink;
use flutter_rust_bridge::frb;
use super::simple::debug_log;

#[frb(opaque)]
pub struct LeakedScreenLogic {
    sink: Option<StreamSink<i32>>,
    data: Option<Vec<u8>>,
}

impl LeakedScreenLogic {
    #[frb(sync)]
    pub fn new() -> LeakedScreenLogic {
        LeakedScreenLogic {
            sink: None,
            data: None,
        }
    }

    pub fn set_sink(&mut self, sink: StreamSink<i32>) {
        self.sink = Some(sink);
    }

    pub async fn receive_data(&self) {
        // get data and send it to sink
    }

    #[frb(sync)]
    pub fn allocate_memory(&mut self) {
        let size = 1024 * 1024 * 100; // 100 mb
        let mut vec = Vec::<u8>::with_capacity(size);
        for _ in 0..size {
            vec.push(0);
        }
        self.data = Some(vec);
    }
}

impl Drop for LeakedScreenLogic {
    fn drop(&mut self) {
        debug_log("drop LeakedScreenLogic".to_string());
    }
}
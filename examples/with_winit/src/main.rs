// Copyright 2022-2025 the Catalina & Vello Authors
// SPDX-License-Identifier: Apache-2.0 OR MIT

//! Winit example.

use anyhow::Result;

fn main() -> Result<()> {
    #[cfg(not(target_os = "android"))]
    {
        with_winit::main()
    }
    #[cfg(target_os = "android")]
    unreachable!()
}

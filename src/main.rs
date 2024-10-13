use dotenvy::dotenv;
use std::{env, error::Error};

fn main() -> Result<(), Box<dyn Error>> {
    dotenv()?;

    let foo_val = env::var("FOO")?;
    println!("FOO: {}", foo_val);

    Ok(())
}

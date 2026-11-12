#[cfg(test)]
mod tests {
    use hegel::TestCase;
    use hegel::generators as gs;

    #[hegel::test]
    fn test_simple_inequality(tc: TestCase) {
        let x = tc.draw(gs::integers::<u64>());
        let y = tc.draw(gs::integers::<u64>());
        assert!(x > y);
    }
}

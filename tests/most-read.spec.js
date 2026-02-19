const { test, expect } = require('@playwright/test');

test('homepage most-read block renders with valid links', async ({ page }) => {
  await page.goto('file:///Users/alan/.openclaw/workspace/code/data-stewardship-unit/_site/index.html');
  await expect(page.getByRole('heading', { name: /Most read this week/i })).toBeVisible();

  const links = page.locator('ol.home-most-read li a');
  await expect(links).toHaveCount(5);

  const count = await links.count();
  for (let i = 0; i < count; i++) {
    const href = await links.nth(i).getAttribute('href');
    expect(href).toBeTruthy();
    expect(href.endsWith('.html')).toBeTruthy();
  }
});

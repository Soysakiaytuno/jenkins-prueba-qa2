import { Given, When, Then } from '@wdio/cucumber-framework';
import StopwatchPage from '../../pageObjects/stopwatchPage.js';
const assert = require('assert');

Given('Estoy en la pestaña de cronómetro', async () => {
  await StopwatchPage.openStopwatchTab();
  await browser.takeScreenshot();
});

When('Inicio el cronómetro', async () => {
  await StopwatchPage.start();
  await browser.takeScreenshot();
});

When('Espero {string} segundos', async (segundos) => {
  const ms = parseFloat(segundos) * 1000;
  await browser.pause(ms);
  await browser.takeScreenshot();
});

When('Detengo el cronómetro', async () => {
  await StopwatchPage.stop();
  await browser.takeScreenshot();
});

When('Pauso el cronómetro', async () => {
  await StopwatchPage.pause();
  await browser.takeScreenshot();
});

When('Reanudo el cronómetro', async () => {
  await StopwatchPage.resume();
  await browser.takeScreenshot();
});

When('Registro una vuelta', async () => {
  await StopwatchPage.recordLap();
  await browser.takeScreenshot();
});

When('Reinicio el cronómetro', async () => {
  await StopwatchPage.resetStopwatch();
  await browser.takeScreenshot();
});

Then('El cronómetro debería marcar {string} segundos', async (segundos) => {
  const secEsperados = parseInt(segundos, 10);
  const timeText = await StopwatchPage.getTimeText();
  const match = timeText.match(/^(\d{2}):(\d{2})\.\d{2}$/);
  assert.ok(match, `El formato del tiempo (${timeText}) no es válido`);
  const minutos = parseInt(match[1], 10);
  const segActuales = minutos * 60 + parseInt(match[2], 10);
  const diferencia = Math.abs(segActuales - secEsperados);
  assert.ok(
    diferencia <= 2,
    `El tiempo marcado fue ${timeText} (${segActuales}s), pero se esperaba alrededor de ${secEsperados}s (tolerancia +-2s)`
  );
  await browser.takeScreenshot();
});

Then('La vuelta número {string} debería estar visible', async (lapNumber) => {
  const visible = await StopwatchPage.isLapDisplayed(lapNumber);
  assert.strictEqual(visible, true, `La vuelta ${lapNumber} no está visible en la lista`);
  await browser.takeScreenshot();
});

Then('El cronómetro debería marcar {string}', async (tiempoEsperado) => {
  const timeText = await StopwatchPage.getTimeText();
  assert.strictEqual(timeText, tiempoEsperado, `El tiempo del cronómetro (${timeText}) no coincide con ${tiempoEsperado}`);
  await browser.takeScreenshot();
});

Then('La vuelta número {string} no debería existir', async (lapNumber) => {
  const existe = await StopwatchPage.lapsExist(lapNumber);
  assert.strictEqual(existe, false, `La vuelta ${lapNumber} aún existe en pantalla`);
  await browser.takeScreenshot();
});

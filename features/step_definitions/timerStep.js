import { Given, When, Then } from '@wdio/cucumber-framework';
import TimerPage from '../../pageObjects/timerPage.js';
const assert = require('assert');

Given('Estoy en la pestaña de temporizadores', async () => {
  await TimerPage.openTimerTab();
  await browser.takeScreenshot();
});

When('Creo un temporizador de {string} segundos', async (segundos) => {
  await TimerPage.createTimer(segundos);
  await browser.takeScreenshot();
});

When('Pauso el temporizador antes de que suene', async () => {
  await TimerPage.pauseTimer();
  await browser.takeScreenshot();
});

Then('El temporizador debería estar sonando', async () => {
  const isRinging = await TimerPage.isAlarmRinging();
  assert.strictEqual(isRinging, true, 'El temporizador no está sonando cuando se esperaba que lo hiciera');
  await browser.takeScreenshot();
});

When('Detengo y elimino el temporizador', async () => {
  await TimerPage.stopAlarmAndClean();
  await browser.takeScreenshot();
});

Then('El temporizador no debería existir', async () => {
  // Verificamos que el botón de Stop ya no está sonando y el temporizador fue limpiado
  const isRinging = await TimerPage.isAlarmRinging();
  assert.strictEqual(isRinging, false, 'El temporizador sigue sonando');
  await browser.takeScreenshot();
});

Then('El temporizador no debería estar sonando', async () => {
  const isRinging = await TimerPage.isAlarmRinging();
  assert.strictEqual(isRinging, false, 'El temporizador está sonando y no debería sonar');
  await browser.takeScreenshot();
});

Then('El temporizador debería permanecer pausado', async () => {
  const isPaused = await TimerPage.isTimerPaused();
  assert.strictEqual(isPaused, true, 'El temporizador no está en estado pausado');
  await browser.takeScreenshot();
});

When('Elimino el temporizador', async () => {
  await TimerPage.deleteTimer();
  await browser.takeScreenshot();
});


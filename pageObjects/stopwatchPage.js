class StopwatchPage {
  
  // 🔹 Selectores
  get stopwatchTab() { 
    return $('id=com.google.android.deskclock:id/tab_menu_stopwatch'); 
  }
  
  get startStopBtn() { 
    return $('id=com.google.android.deskclock:id/start_stop_button'); 
  }
  
  get resetBtn() { 
    return $('id=com.google.android.deskclock:id/reset_button'); 
  }
  
  get lapBtn() { 
    return $('android=new UiSelector().text("Lap")'); 
  }
  
  get timeDisplay() { 
    return $('id=com.google.android.deskclock:id/stopwatch_time_text'); 
  }

  lapItem(lapNumber) {
    return $(`android=new UiSelector().text("${lapNumber}")`);
  }

  // 🔹 Métodos de acción
  async openStopwatchTab() {
    await this.stopwatchTab.waitForDisplayed({ timeout: 5000 });
    await this.stopwatchTab.click();
    await this.startStopBtn.waitForDisplayed({ timeout: 5000 });
    await this.resetStopwatch();
  }

  async resetStopwatch() {
    // Si el botón está visible y muestra "Stop", está corriendo: pausarlo
    try {
      if (await this.startStopBtn.isDisplayed()) {
        const text = await this.startStopBtn.getText();
        if (text === 'Stop') {
          await this.startStopBtn.click();
        }
      }
    } catch (e) {}

    // Si el botón Reset está visible, presionarlo
    try {
      if (await this.resetBtn.isDisplayed()) {
        await this.resetBtn.click();
      }
    } catch (e) {}
  }

  async start() {
    await this.startStopBtn.waitForDisplayed({ timeout: 5000 });
    await this.startStopBtn.click();
  }

  async pause() {
    await this.startStopBtn.waitForDisplayed({ timeout: 5000 });
    await this.startStopBtn.click();
  }

  async stop() {
    await this.startStopBtn.waitForDisplayed({ timeout: 5000 });
    await this.startStopBtn.click();
  }

  async resume() {
    await this.startStopBtn.waitForDisplayed({ timeout: 5000 });
    await this.startStopBtn.click();
  }

  async recordLap() {
    await this.lapBtn.waitForDisplayed({ timeout: 5000 });
    await this.lapBtn.click();
  }

  async getTimeText() {
    await this.timeDisplay.waitForDisplayed({ timeout: 5000 });
    return await this.timeDisplay.getText();
  }

  async isLapDisplayed(lapNumber) {
    const lap = this.lapItem(lapNumber);
    await lap.waitForDisplayed({ timeout: 5000 });
    return await lap.isDisplayed();
  }

  async lapsExist(lapNumber) {
    const laps = await $$( `android=new UiSelector().text("${lapNumber}")` );
    return laps.length > 0;
  }
}

module.exports = new StopwatchPage();

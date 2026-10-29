class TimerPage {

  // 🔹 Selectores
  get timerTab() { 
    return $('id=com.google.android.deskclock:id/tab_menu_timer'); 
  }

  get startTimerBtn() { 
    return $('id=com.google.android.deskclock:id/add_timer_button'); 
  }

  get stopAlarmBtn() { 
    return $('~Stop'); 
  }

  get pauseTimerBtn() { 
    return $('~Pause'); 
  }

  get resumeTimerBtn() { 
    return $('~Start'); 
  }

  get deleteTimerBtn() { 
    return $('id=com.google.android.deskclock:id/tertiary_button'); 
  }

  get fabAddTimer() { 
    return $('id=com.google.android.deskclock:id/fab'); 
  }

  digitBtn(digit) {
    return $(`id=com.google.android.deskclock:id/timer_setup_digit_${digit}`);
  }

  // 🔹 Métodos de acción
  async openTimerTab() {
    await this.timerTab.waitForDisplayed({ timeout: 5000 });
    await this.timerTab.click();
    await browser.pause(1000);
    await this.cleanExistingTimer();
  }

  async cleanExistingTimer() {
    // Si la alarma está sonando, detenerla
    try {
      if (await this.stopAlarmBtn.isDisplayed()) {
        await this.stopAlarmBtn.click();
      }
    } catch (e) {}

    // Si hay un temporizador activo o pausado, eliminarlo
    try {
      if (await this.deleteTimerBtn.isDisplayed()) {
        await this.deleteTimerBtn.click();
      }
    } catch (e) {}
  }

  async createTimer(seconds) {
    // Si la pantalla de configuración no está visible (hay otro timer), pulsar '+'
    try {
      if (await this.fabAddTimer.isDisplayed()) {
        await this.fabAddTimer.click();
      }
    } catch (e) {}

    // Presionar los dígitos del número de segundos
    const digits = String(seconds).split('');
    for (const d of digits) {
      const btn = this.digitBtn(d);
      await btn.waitForDisplayed({ timeout: 5000 });
      await btn.click();
    }

    // Iniciar temporizador
    await this.startTimerBtn.waitForDisplayed({ timeout: 5000 });
    await this.startTimerBtn.click();
  }

  async pauseTimer() {
    await this.pauseTimerBtn.waitForDisplayed({ timeout: 5000 });
    await this.pauseTimerBtn.click();
  }

  async isAlarmRinging() {
    try {
      await this.stopAlarmBtn.waitForDisplayed({ timeout: 4000 });
      return await this.stopAlarmBtn.isDisplayed();
    } catch {
      return false;
    }
  }

  async isTimerPaused() {
    try {
      await this.resumeTimerBtn.waitForDisplayed({ timeout: 4000 });
      return await this.resumeTimerBtn.isDisplayed();
    } catch {
      return false;
    }
  }

  async stopAlarmAndClean() {
    try {
      if (await this.stopAlarmBtn.isDisplayed()) {
        await this.stopAlarmBtn.click();
      }
    } catch (e) {}

    try {
      if (await this.deleteTimerBtn.isDisplayed()) {
        await this.deleteTimerBtn.click();
      }
    } catch (e) {}
  }

  async deleteTimer() {
    try {
      if (await this.deleteTimerBtn.isDisplayed()) {
        await this.deleteTimerBtn.click();
      }
    } catch (e) {}
  }
}

module.exports = new TimerPage();

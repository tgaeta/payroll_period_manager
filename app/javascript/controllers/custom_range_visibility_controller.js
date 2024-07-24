import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['customRange', 'periodType', 'customRangeInput'];

  connect() {
    this.toggleCustomRange();
  }

  toggleCustomRange() {
    const selectedType = this.periodTypeTarget.value;
    if (selectedType === 'custom') {
      this.customRangeTarget.classList.remove('hidden');
    } else {
      this.customRangeTarget.classList.add('hidden');
      this.clearCustomRange();
    }
  }

  clearCustomRange() {
    this.customRangeInputTarget.value = '';
  }
}

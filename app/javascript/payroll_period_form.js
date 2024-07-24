document.addEventListener('turbo:load', () => {
  const periodTypeSelect = document.getElementById('period_type_select');
  const customRangeField = document.getElementById('custom_range_field');

  function toggleCustomRangeField() {
    if (periodTypeSelect && customRangeField) {
      if (periodTypeSelect.value === 'custom') {
        customRangeField.style.display = 'block';
      } else {
        customRangeField.style.display = 'none';
      }
    }
  }

  if (periodTypeSelect) {
    periodTypeSelect.addEventListener('change', toggleCustomRangeField);
    // Call the function on page load to set the initial state
    toggleCustomRangeField();
  }
});

// For non-Turbo environments, also listen for DOMContentLoaded
document.addEventListener('DOMContentLoaded', () => {
  if (typeof Turbo === 'undefined') {
    const event = new Event('turbo:load');
    document.dispatchEvent(event);
  }
});

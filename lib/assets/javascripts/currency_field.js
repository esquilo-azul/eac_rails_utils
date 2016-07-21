function CurrencyField(hidden_id, visible_id, options) {
  this.hidden_id = hidden_id;
  this.visible_id = visible_id;
  this.options = options;
  var THIS = this;
  $(document).ready(function () {
    THIS.visibleInput().maskMoney(THIS.options);
    THIS.visibleInput().maskMoney('mask', parseFloat(THIS.hiddenInput().val()));
    THIS.visibleInput().change(function () {
      THIS.hiddenInput().val(THIS.visibleInput().maskMoney('unmasked')[0]);
    })
  });
}

CurrencyField.prototype.hiddenInput = function () {
  return $('#' + this.hidden_id);
}

CurrencyField.prototype.visibleInput = function () {
  return $('#' + this.visible_id);
}

InputSearchable = function (options) {
  var THIS = this;
  this._options = options;
  this._selectedItem = null;
  this._lastSelectedItem = null;

  $(document).ready(function () {
    THIS._visibleInput().attr('owner', THIS);

    THIS._visibleInput().autocomplete({
      source: THIS._option('url'),
      delay: 0,
      select: function (event, ui) {
        THIS._setValue(ui.item);
      },
      autoFocus: true
    });
    THIS._visibleInput().on('input', function (event) {
      THIS._checkTextChanged(event);
    });
    THIS._setValue({id: THIS._option('initial_id'), label: THIS._option('initial_label')});
  });
};

InputSearchable.prototype._option = function (key) {
  if (this._options[key] === undefined) {
    throw 'Opção não encontrada: ' + key;
  }
  return this._options[key];
};

InputSearchable.prototype._hiddenInput = function () {
  return this._byId(this._option('hidden_input_id'));
};

InputSearchable.prototype._visibleInput = function () {
  return this._byId(this._option('visible_input_id'));
};

InputSearchable.prototype._byId = function (id) {
  var name = "#" + id;
  if ($(name).length === 0) {
    console.log(name + ' nao existe');
  }
  return  $(name);
};

InputSearchable.prototype._applyColor = function () {
  var color = this._hiddenInput().val() ? '#CFC' : '#FCC';
  this._visibleInput().css('background-color', color);
};

InputSearchable.prototype._checkTextChanged = function (event) {
  if (this._selectedItem) {
    if (this._selectedItem.label != this._visibleInput().val()) {
      this._setValue(null);
    }
  }
  if (this._lastSelectedItem) {
    if (this._lastSelectedItem.label == this._visibleInput().val()) {
      this._setValue(this._lastSelectedItem);
    }
  }
};

InputSearchable.prototype._setValue = function (item) {
  if (item) {
    this._hiddenInput().val(item.id);
    this._visibleInput().val(item.label);
    this._selectedItem = item;
    this._lastSelectedItem = this._selectedItem;
  }
  else {
    this._hiddenInput().val(null);
    this._selectedItem = null;
  }
  this._applyColor();
};
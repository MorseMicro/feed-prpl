'use strict';
'require view';
'require form';
'require rpc';
'require uci';
'require ui';

var callRestartPrplmesh = rpc.declare({
	object: 'prplmesh',
	method: 'restart',
	expect: { '': {} }
});

var callUciCommit = rpc.declare({
	object: 'uci',
	method: 'commit',
	params: [ 'config' ]
});

var cbiModeSelectorValue = form.ListValue.extend({
	__init__: function(/* ... */) {
		this.super('__init__', arguments);
		this.value('agent', E('div', { 'style': 'display:inline-block;vertical-align:top;margin-bottom:1em' }, [
			E('strong', [ _('Agent') ]), E('br')
		]));

		this.value('controller', E('div', { 'style': 'display:inline-block;vertical-align:top;margin-bottom:1em' }, [
			E('strong', [ _('Controller+Agent') ]), E('br')
		]));
	},

	renderWidget: function(section_id, option_index, cfgvalue) {
		var choices = this.transformChoices();
        var widget = new ui.Select((cfgvalue != null) ? cfgvalue : this.default, choices, {
			id: this.cbid(section_id),
			size: this.size,
			sort: this.keylist,
			optional: this.optional,
			placeholder: this.placeholder,
			validate: L.bind(this.validate, this, section_id),
			disabled: (this.readonly != null) ? this.readonly : this.map.readonly,
			widget: 'radio',
			orientation: 'vertical'
		});

		var nodes = widget.render();

		nodes.querySelectorAll('input[type="radio"]').forEach(L.bind(function(radio) {
			radio.addEventListener('change', ui.createHandlerFn(this, 'handleModeChange', section_id, radio.getAttribute('value')));
		}, this));

		return nodes;
	},

	cfgvalue: function(section_id) {
		var mode = uci.get('prplmesh', section_id, 'management_mode')
		switch(mode) {
		case 'Multi-AP-Controller-and-Agent':
			return 'controller';
		case 'Multi-AP-Agent':
			return 'agent';
		default:
			throw "Unknown management mode '" + mode + "'!"
		}
	},

	handleModeChange: function(section_id, value) {
		switch(value) {
		case 'controller':
			uci.set('prplmesh', "config", 'management_mode', 'Multi-AP-Controller-and-Agent');
			uci.set('prplmesh', "config", 'operating_mode', 'Gateway');
			uci.set('prplmesh', "config", 'master', '1');
			uci.set('prplmesh', "config", 'gateway', '1');
			break;
		case 'agent':
			uci.set('prplmesh', "config", 'management_mode', 'Multi-AP-Agent');
			uci.set('prplmesh', "config", 'operating_mode', 'WDS-Repeater');
			uci.set('prplmesh', "config", 'master', '0');
			uci.set('prplmesh', "config", 'gateway', '0');
			break;
		}
		return handleApply(this.map);
	}
});

function handleApply(map) {
	var dlg = ui.showModal(null, [ E('em', { 'class': 'spinning' }, [ _('Saving configuration…') ]) ]);
	dlg.removeChild(dlg.firstElementChild);

	return map.save(null, true).then(function() {
		return callUciCommit('prplmesh');
	}).then(function() {
		return Promise.all([
			L.resolveDefault(callRestartPrplmesh(), {})
		]);
	}).catch(function(err) {
		ui.addNotification(null, [ E('p', [ _('Failed to save configuration: %s').format(err) ]) ])
	}).finally(function() {
		map.reset();
		ui.hideIndicator('uci-changes');
		ui.hideModal();
	});
}

return view.extend({
	load: function() {
		 return Promise.all([
			 L.resolveDefault(uci.load('network')),
		 ]);
	 },


	render: function() {
		var m, s, o;

		m = new form.Map('prplmesh', _('prplMesh'));

		s = m.section(form.NamedSection, 'config', _('Mode'), _('Mode'), _('The prplMesh mode controls whether the device acts as an EasyMesh agent or controller+agent.<br>Running an Easymesh controller on your network allows you to configure all the Easymesh agents from a single place (make sure there is only one controller in the network).<br>For more information about Easymesh and prplMesh, see <a href="https://gitlab.com/prpl-foundation/prplmesh/prplMesh/-/wikis/Introduction-to-prplMesh">the prplMesh introduction page</a>.'));
		s.addremove = false;

		o = s.option(cbiModeSelectorValue, 'mode');

		s = m.section(form.NamedSection, 'config', _('Backhaul Settings'), _('Backhaul Settings'), _('For a prplMesh agent, the backhaul is the connection to the controller.<br>After saving the settings below, you will have to restart prplMesh (or reboot the device).'));
		s.addremove = false;

		o = s.option(form.Value, 'backhaul_wire_iface', _('Wired backhaul interface'));
		o.placeholder = _('Select Interface');

		L.toArray(uci.get('network', 'lan', 'ifname')).forEach(function(ifname) {
			o.value(ifname, ifname);
		});

		return m.render();
	},

});

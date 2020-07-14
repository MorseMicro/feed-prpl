'use strict';
'require view';
'require form';
'require tools.widgets as widgets';

return view.extend({
	render: function() {
		var m, s, o;

		m = new form.Map('obuspa', _('USP / TR-369'));

		s = m.section(form.NamedSection, 'mtp', _('Enable'));
		s.anonymous   = false;
		s.addremove   = false;
		s.addbtntitle = _('USP settings');

		o = s.option(form.Flag, 'enable', _('Enable'));
		o.enabled = 'true';
		o.disabled = 'false'

		s = m.section(form.NamedSection, 'connection', _('Connection'), _('Connection Settings'));
		s.anonymous   = true;
		s.addremove   = false;
		s.addbtntitle = _('USP settings');

		o = s.option(form.Value, 'endpoint', _('Endpoint'));
		o.depends('obuspa.mtp.enable', 'true');
		o.default = 'self::example.controller.com';

		o = s.option(form.Value, 'host', _('Host'));
		o.depends('obuspa.mtp.enable', 'true');
		o.default = 'example.controller.com';

		o = s.option(form.Value, 'username', _('Username'));
		o.depends('obuspa.mtp.enable', 'true');

		o = s.option(form.Value, 'password', _('Password'));
		o.depends('obuspa.mtp.enable', 'true');

		return m.render();
	}
});


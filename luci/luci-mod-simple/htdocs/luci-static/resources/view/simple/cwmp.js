'use strict';
'require view';
'require form';
'require tools.widgets as widgets';

return view.extend({
	render: function() {
		var m, s, o, t;

		m = new form.Map('cwmp', 'CWMP / TR-069');

		s = m.section(form.NamedSection, 'cwmp', _('Enable'));
		s.anonymous   = false;
		s.addremove   = false;
		s.addbtntitle = _('ACS settings');

		o = s.option(form.Flag, 'enabled', _('Enable'));
		o.enabled = '1';
		o.disabled = '0'

		s = m.section(form.NamedSection, 'acs', _('ACS'), 'ACS Settings');
		s.anonymous   = false;
		s.addremove   = false;
		s.addbtntitle = _('ACS settings');

		o = s.option(form.Value, 'url', _('URL'));
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Value, 'username', _('Username'));
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Value, 'password', _('Password'));
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Flag, 'periodic_inform_enable', _('Periodic Inform'));
		o.enabled  = '1';
		o.disabled = '0';
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Value, 'periodic_inform_interval', _('Periodic Inform Interval'));
		o.depends({ 'cwmp.cwmp.enabled': '1', 'periodic_inform_enable': '1' });

		o = s.option(form.Value, 'periodic_inform_time', _('Periodic Inform Time'));
		o.depends({ 'cwmp.cwmp.enabled': '1', 'periodic_inform_enable': '1' });

		o = s.option(form.Flag, 'dhcp_discovery', _('DHCP Discovery'));
		o.enabled  = 'enable';
		o.disabled = 'disable';
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Value, 'ParameterKey', _('Parameter Key'));
		o.depends('cwmp.cwmp.enabled', '1');

		s = m.section(form.NamedSection, 'cpe', _('CPE'), 'CPE Settings');
		s.anonymous   = false;
		s.addremove   = false;
		s.addbtntitle = _('CPE settings');

		o = s.option(form.Value, 'port', _('Port'));
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Value, 'userid', _('Username'));
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Value, 'passwd', _('Password'));
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Value, 'provisioning_code', _('Provisioning Code'));
		o.depends('cwmp.cwmp.enabled', '1');

		o = s.option(form.Flag, 'dhcp_discovery', _('Managed Upgrades'));
		o.enabled  = 'true';
		o.disabled = 'false';
		o.depends('cwmp.cwmp.enabled', '1');

		return m.render();
	}
});


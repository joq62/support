%% This is the application resource file (.app file) for the 'base'
%% application.
{application, support_unit_test,
[{description, "support_unit_test  " },
{vsn, "1.0.0" },
{modules, 
	  [support_unit_test_app,support_unit_test_sup,support_unit_test]},
{registered,[support_unit_test]},
{applications, [kernel,stdlib]},
{mod, {support_unit_test_app,[]}},
{start_phases, []}
]}.

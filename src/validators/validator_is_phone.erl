% Nitrogen Web Framework for Erlang
% Copyright (c) 2008-2010 Rusty Klophaus
% See MIT-LICENSE for licensing information.

-module (validator_is_phone).
-include_lib ("wf.hrl").
-compile(export_all).

render_action(Record)  ->
    TriggerPath= Record#is_phone.trigger,
    TargetPath = Record#is_phone.target,
    Text = wf:js_escape(Record#is_phone.text),
    validator_custom:render_action(#custom { 
        trigger=TriggerPath, 
        target=TargetPath, 
        function=fun validate/2, text = Text, tag=Record 
    }),
    wf:f("v.add(Validate.Phone, { failureMessage: \"~s\" });", [Text]).

validate(_, Value) ->
    case re:run(wf:to_list(Value), "^(8|(\\+(3|7))[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{7,10}$" ) of
        {match, _} -> true;
        _ -> false
    end.

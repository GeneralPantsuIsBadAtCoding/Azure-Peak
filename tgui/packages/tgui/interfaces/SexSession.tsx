import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Box, Button, Input, Section, Stack } from 'tgui-core/components';

import { ActionButton } from './sexcon/ActionButton';
import { ProgressBars } from './sexcon/ProgressBars';
import type { SexAction, SexSessionData } from './sexcon/types';

export const SexSession = () => {
  const { act, data } = useBackend<SexSessionData>();
  const [searchText, setSearchText] = useState('');
  const [arousalInput, setArousalInput] = useState('');

  // Split actions into two columns
  const filteredActions = data.actions.filter((action) =>
    action.name.toLowerCase().includes(searchText.toLowerCase())
  );

  const leftColumn: SexAction[] = [];
  const rightColumn: SexAction[] = [];
  filteredActions.forEach((action, index) => {
    if (index % 2 === 0) {
      leftColumn.push(action);
    } else {
      rightColumn.push(action);
    }
  });
  
  const onClickActionButton = (actionType: string) => {
    if(data.current_action === actionType) {
      act('stop_action');
      return;
    }
    act('start_action', { action_type: actionType });
  };

  return (
    <Window title="Sate Desires" width={500} height={600}>
      <Window.Content scrollable>
        <Stack vertical fill>
          {/* Header */}
          <Stack.Item>
            <Box textAlign="center" bold fontSize="1.1em">
              {data.title}
            </Box>
            {data.session_name && data.session_name !== 'Private Session' && (
              <Box textAlign="center" color="label" fontSize="0.9em">
                {data.session_name}
              </Box>
            )}
          </Stack.Item>

          {/* Progress Bars */}
          <Stack.Item>
            <ProgressBars
              arousal={data.arousal}
              pleasure={data.pleasure}
              pain={data.pain}
            />
          </Stack.Item>

          {/* Controls - All in one compact section */}
          <Stack.Item>
            <Section>
              <Stack vertical>
                {/* Speed and Force */}
                <Stack.Item>
                  <Box textAlign="center">
                    <Button
                      inline
                      compact
                      onClick={() => act('set_speed', { value: Math.max(1, data.speed - 1) })}
                    >
                      &lt;
                    </Button>
                    {' '}
                    <Box as="span" bold>
                      {data.speed_names[data.speed - 1]}
                    </Box>
                    {' '}
                    <Button
                      inline
                      compact
                      onClick={() => act('set_speed', { value: Math.min(4, data.speed + 1) })}
                    >
                      &gt;
                    </Button>
                    {' ~|~ '}
                    <Button
                      inline
                      compact
                      onClick={() => act('set_force', { value: Math.max(1, data.force - 1) })}
                    >
                      &lt;
                    </Button>
                    {' '}
                    <Box as="span" bold>
                      {data.force_names[data.force - 1]}
                    </Box>
                    {' '}
                    <Button
                      inline
                      compact
                      onClick={() => act('set_force', { value: Math.min(4, data.force + 1) })}
                    >
                      &gt;
                    </Button>
                  </Box>
                </Stack.Item>

                {/* Finish Condition */}
                <Stack.Item>
                  <Box textAlign="center">
                    |{' '}
                    <Button
                      inline
                      compact
                      color={data.do_until_finished ? 'good' : 'default'}
                      onClick={() => act('toggle_finished')}
                    >
                      {data.do_until_finished ? "UNTIL I'M FINISHED" : 'UNTIL I STOP'}
                    </Button>
                    {' '}|
                  </Box>
                </Stack.Item>

                {/* Arousal Controls */}
                <Stack.Item>
                  <Stack>
                    <Stack.Item grow>
                      <Input
                        fluid
                        placeholder="Set arousal..."
                        value={arousalInput}
                        onChange={setArousalInput}
                        onEnter={() => {
                          const amount = parseInt(arousalInput, 10);
                          if (!isNaN(amount)) {
                            act('set_arousal_value', { amount });
                            setArousalInput('');
                          }
                        }}
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        onClick={() => {
                          const amount = parseInt(arousalInput, 10);
                          if (!isNaN(amount)) {
                            act('set_arousal_value', { amount });
                            setArousalInput('');
                          }
                        }}
                      >
                        SET
                      </Button>
                    </Stack.Item>
                    <Stack.Item>
                      <Button onClick={() => act('freeze_arousal')}>
                        {data.frozen ? 'UNFREEZE' : 'FREEZE'}
                      </Button>
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Box textAlign="center" italic color="label">
                    Doing unto {data.title.replace('Interacting with ', '').replace('...', '')}
                  </Box>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>

          {/* Search */}
          <Stack.Item>
            <Input
              fluid
              placeholder="Search for an interaction..."
              value={searchText}
              onChange={setSearchText}
            />
          </Stack.Item>

          {/* Two-Column Action Grid */}
          <Stack.Item grow>
            <Section fill scrollable>
              <Stack fill>
                {/* Left Column */}
                <Stack.Item basis="50%">
                  <Stack vertical>
                    {leftColumn.map((action) => {
                      const isCurrentAction = data.current_action === action.type;
                      const isAvailable = data.can_perform.includes(action.type);

                      return (
                        <Stack.Item key={action.type}>
                          <Box textAlign="center">
                            <ActionButton
                              action={action}
                              isCurrentAction={isCurrentAction}
                              isAvailable={isAvailable}
                              onClick={() => onClickActionButton(action.type)}
                              tooltipPosition="right"
                            />
                          </Box>
                        </Stack.Item>
                      );
                    })}
                  </Stack>
                </Stack.Item>

                {/* Right Column */}
                <Stack.Item basis="50%">
                  <Stack vertical>
                    {rightColumn.map((action) => {
                      const isCurrentAction = data.current_action === action.type;
                      const isAvailable = data.can_perform.includes(action.type);

                      return (
                        <Stack.Item key={action.type}>
                          <Box textAlign="center">
                            <ActionButton
                              action={action}
                              isCurrentAction={isCurrentAction}
                              isAvailable={isAvailable}
                              onClick={() => act('start_action', { action_type: action.type })}
                              tooltipPosition="left"
                            />
                          </Box>
                        </Stack.Item>
                      );
                    })}
                  </Stack>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

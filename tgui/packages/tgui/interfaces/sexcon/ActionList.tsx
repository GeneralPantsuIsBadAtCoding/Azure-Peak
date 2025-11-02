import { Box, Button, Input, Section, Stack } from 'tgui-core/components';

import type { SexAction } from './types';

interface ActionListProps {
  actions: SexAction[];
  canPerform: string[];
  currentAction: string | null;
  searchText: string;
  onSearchChange: (text: string) => void;
  onStartAction: (actionType: string) => void;
  onStopAction: () => void;
}

export const ActionList = (props: ActionListProps) => {
  const {
    actions,
    canPerform,
    currentAction,
    searchText,
    onSearchChange,
    onStartAction,
    onStopAction,
  } = props;

  // Filter actions based on search text
  const filteredActions = actions.filter((action) =>
    action.name.toLowerCase().includes(searchText.toLowerCase())
  );

  return (
    <Section fill>
      <Stack vertical fill>
        {/* Search Box */}
        <Stack.Item>
          <Input
            fluid
            placeholder="Search for an interaction..."
            value={searchText}
            onChange={onSearchChange}
          />
        </Stack.Item>

        {/* Stop Current Action Button */}
        {currentAction && (
          <Stack.Item>
            <Button
              fluid
              color="bad"
              icon="stop"
              onClick={onStopAction}
            >
              STOP CURRENT ACTION
            </Button>
          </Stack.Item>
        )}

        {/* Action List */}
        <Stack.Item grow>
          <Section fill scrollable>
            <Stack vertical>
              {filteredActions.map((action) => {
                const isCurrentAction = currentAction === action.type;
                const isAvailable = canPerform.includes(action.type);

                return (
                  <Stack.Item key={action.type}>
                    <Button
                      fluid
                      color={isCurrentAction ? 'good' : isAvailable ? 'default' : 'disabled'}
                      icon={isCurrentAction ? 'check' : action.requires_grab ? 'hand-rock' : 'hand-paper'}
                      disabled={!isAvailable && !isCurrentAction}
                      onClick={() => onStartAction(action.type)}
                      tooltip={action.description}
                      tooltipPosition="right"
                    >
                      <Stack>
                        <Stack.Item grow>
                          {action.name}
                        </Stack.Item>
                        {action.requires_grab && (
                          <Stack.Item>
                            <Box as="span" color="label" fontSize="0.9em">
                              [GRAB]
                            </Box>
                          </Stack.Item>
                        )}
                      </Stack>
                    </Button>
                  </Stack.Item>
                );
              })}

              {filteredActions.length === 0 && (
                <Box italic color="label" textAlign="center" mt={2}>
                  No actions found matching &ldquo;{searchText}&rdquo;
                </Box>
              )}
            </Stack>
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

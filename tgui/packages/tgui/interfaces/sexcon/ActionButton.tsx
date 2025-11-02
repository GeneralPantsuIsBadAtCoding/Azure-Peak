import { Button } from 'tgui-core/components';

interface ActionButtonProps {
  action: {
    name: string;
    type: string;
    description: string;
  };
  isCurrentAction: boolean;
  isAvailable: boolean;
  onClick: () => void;
  tooltipPosition?: 'left' | 'right';
}

export const ActionButton = (props: ActionButtonProps) => {
  const { action, isCurrentAction, isAvailable, onClick, tooltipPosition = 'right' } = props;

  return (
    <Button
      fluid
      color={isCurrentAction ? 'good' : isAvailable ? 'default' : 'disabled'}
      disabled={!isAvailable && !isCurrentAction}
      onClick={onClick}
      tooltip={action.description}
      tooltipPosition={tooltipPosition}
    >
      {action.name}
    </Button>
  );
};

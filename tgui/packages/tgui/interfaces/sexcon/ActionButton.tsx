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
}

export const ActionButton = (props: ActionButtonProps) => {
  const { action, isCurrentAction, isAvailable, onClick } = props;

  const handleClick = () => {
    // Don't allow clicking disabled buttons (unless it's the current action)
    if (!isAvailable && !isCurrentAction) {
      return;
    }
    onClick();
  };

  const buttonStyle = isCurrentAction
    ? { color: '#7b5353', borderColor: '#7b5353' }
    : !isAvailable
      ? { color: '#5e5959', opacity: 0.7, cursor: 'default' }
      : { color: '#7b5353' };

  return (
    <Button
      fluid
      color="transparent"
      onClick={handleClick}
      style={buttonStyle}
    >
      {action.name}
    </Button>
  );
};

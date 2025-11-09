import { PropsWithChildren } from 'react';

type Props = PropsWithChildren;

export const WindowDecor = (props: Props) => {
  return (
    <>
      <div className="TopDecorLeft" />
      <div className="TopDecorRight" />
      <div className="TopDecorMiddle" />
      <div className="LowerDecorRight">
        <div className="LowerDecorMiddle" />
        <div className="LowerDecorLeft" />
      </div>
    </>
  );
};

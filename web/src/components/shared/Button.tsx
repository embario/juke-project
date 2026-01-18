import { ButtonHTMLAttributes } from 'react';
import clsx from 'clsx';

type Props = ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: 'primary' | 'ghost';
};

const Button = ({ variant = 'primary', className, children, ...rest }: Props) => (
  <button
    className={clsx(
      'btn',
      variant === 'primary' && 'btn-primary',
      variant === 'ghost' && 'btn-ghost',
      className,
    )}
    {...rest}
  >
    {children}
  </button>
);

export default Button;

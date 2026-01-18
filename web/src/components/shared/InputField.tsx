import { InputHTMLAttributes } from 'react';
import clsx from 'clsx';

type Props = InputHTMLAttributes<HTMLInputElement> & {
  label: string;
  error?: string;
};

const InputField = ({ label, error, className, id, ...rest }: Props) => {
  const computedId = id ?? rest.name;
  return (
    <label className="field">
      <span className="field__label" htmlFor={computedId}>
        {label}
      </span>
      <input id={computedId} className={clsx('field__input', className, { 'field__input--error': error })} {...rest} />
      {error ? <span className="field__error">{error}</span> : null}
    </label>
  );
};

export default InputField;

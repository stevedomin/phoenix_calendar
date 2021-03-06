if Code.ensure_loaded?(Phoenix.HTML) do
  defimpl Phoenix.HTML.Safe, for: [Calendar.DateTime, Calecto.DateTime, Calecto.DateTimeUTC] do
    def to_iodata(%{usec: usec} = t) when usec == nil do
      "#{Calendar.Strftime.strftime!(t, "%F %T")} #{t.timezone}"
    end
    def to_iodata(t) do
      decimals = String.rjust("#{t.usec}", 6, ?0) # pad microsecs with zeroes
      "#{Calendar.Strftime.strftime!(t, "%F %T")}.#{decimals} #{t.timezone}"
    end
  end
  defimpl Phoenix.HTML.Safe, for: [Calendar.NaiveDateTime, Calecto.NaiveDateTime] do
    def to_iodata(%{usec: usec} = t) when usec == nil do
      "#{Calendar.Strftime.strftime!(t, "%F %T")}"
    end
    def to_iodata(t) do
      decimals = String.rjust("#{t.usec}", 6, ?0) # pad microsecs with zeroes
      "#{Calendar.Strftime.strftime!(t, "%F %T")}.#{decimals}"
    end
  end
  defimpl Phoenix.HTML.Safe, for: [Calendar.Date, Calecto.Date] do
    def to_iodata(t) do
      Calendar.Strftime.strftime!(t, "%F")
    end
  end
  defimpl Phoenix.HTML.Safe, for: [Calendar.Time, Calecto.Time] do
    def to_iodata(t) do
      Calendar.Strftime.strftime!(t, "%T")
    end
  end
end
